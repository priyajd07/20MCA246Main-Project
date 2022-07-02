import numpy as np
import cv2
import pywt
import random
import math
import cmath

from PIL import Image



def applyWatermarkDFT(imageMatrix, watermarkMatrix, alpha):
    shiftedDFT = np.fft.fftshift(np.fft.fft2(imageMatrix))
    watermarkedDFT = shiftedDFT + alpha * watermarkMatrix
    watermarkedImage = np.fft.ifft2(np.fft.ifftshift(watermarkedDFT))

    return watermarkedImage




def DWT(coverImage, watermarkImage):
    coverImage = cv2.resize(coverImage, (300, 300))
    cv2.imshow('Cover Image', coverImage)
    watermarkImage = cv2.resize(watermarkImage, (150, 150))
    cv2.imshow('Watermark Image', watermarkImage)

    # DWT on cover image
    coverImage = np.float32(coverImage)
    coverImage /= 255;
    coeffC = pywt.dwt2(coverImage, 'haar')
    cA, (cH, cV, cD) = coeffC

    watermarkImage = np.float32(watermarkImage)
    watermarkImage /= 255;

    # Embedding
    coeffW = (0.4 * cA + 0.1 * watermarkImage, (cH, cV, cD))
    watermarkedImage = pywt.idwt2(coeffW, 'haar')
    cv2.imshow('Watermarked Image', watermarkedImage)

    # Extraction
    coeffWM = pywt.dwt2(watermarkedImage, 'haar')
    hA, (hH, hV, hD) = coeffWM

    extracted = (hA - 0.4 * cA) / 0.1
    extracted *= 255
    extracted = np.uint8(extracted)
    cv2.imshow('Extracted', extracted)



def SVD(coverImage, watermarkImage):
    cv2.imshow('Cover Image', coverImage)
    [m, n] = np.shape(coverImage)
    coverImage = np.double(coverImage)
    cv2.imshow('Watermark Image', watermarkImage)
    watermarkImage = np.double(watermarkImage)

    # SVD of cover image
    ucvr, wcvr, vtcvr = np.linalg.svd(coverImage, full_matrices=1, compute_uv=1)
    Wcvr = np.zeros((m, n), np.uint8)
    Wcvr[:m, :n] = np.diag(wcvr)
    Wcvr = np.double(Wcvr)
    [x, y] = np.shape(watermarkImage)

    # modifying diagonal component
    for i in range(0, x):
        for j in range(0, y):
            Wcvr[i, j] = (Wcvr[i, j] + 0.01 * watermarkImage[i, j]) / 255

    # SVD of wcvr
    u, w, v = np.linalg.svd(Wcvr, full_matrices=1, compute_uv=1)

    # Watermarked Image
    S = np.zeros((225, 225), np.uint8)
    S[:m, :n] = np.diag(w)
    S = np.double(S)
    wimg = np.matmul(ucvr, np.matmul(S, vtcvr))
    wimg = np.double(wimg)
    wimg *= 255
    watermarkedImage = np.zeros(wimg.shape, np.double)
    normalized = cv2.normalize(wimg, watermarkedImage, 1.0, 0.0, cv2.NORM_MINMAX)
    cv2.imshow('Watermarked Image', watermarkedImage)


def DWT_SVD(coverImage, watermarkImage):
    cv2.imshow('Cover Image', coverImage)
    [m, n] = np.shape(coverImage)
    coverImage = np.double(coverImage)
    cv2.imshow('Watermark Image', watermarkImage)
    watermarkImage = np.double(watermarkImage)

    # Applying DWT on cover image and getting four sub-bands
    coverImage = np.float32(coverImage)
    coverImage /= 255;
    coeffC = pywt.dwt2(coverImage, 'haar')
    cA, (cH, cV, cD) = coeffC

    # SVD on cA
    uA, wA, vA = np.linalg.svd(cA, full_matrices=1, compute_uv=1)
    [a1, a2] = np.shape(cA)
    WA = np.zeros((a1, a2), np.uint8)
    WA[:a1, :a2] = np.diag(wA)

    # SVD on cH
    uH, wH, vH = np.linalg.svd(cH, full_matrices=1, compute_uv=1)
    [h1, h2] = np.shape(cH)
    WH = np.zeros((h1, h2), np.uint8)
    WH[:h1, :h2] = np.diag(wH)

    # SVD on cV
    uV, wV, vV = np.linalg.svd(cV, full_matrices=1, compute_uv=1)
    [v1, v2] = np.shape(cV)
    WV = np.zeros((v1, v2), np.uint8)
    WV[:v1, :v2] = np.diag(wV)

    # SVD on cD
    uD, wD, vD = np.linalg.svd(cD, full_matrices=1, compute_uv=1)
    [d1, d2] = np.shape(cV)
    WD = np.zeros((d1, d2), np.uint8)
    WD[:d1, :d2] = np.diag(wD)

    # SVD on watermarked image
    uw, ww, vw = np.linalg.svd(watermarkImage, full_matrices=1, compute_uv=1)
    [x, y] = np.shape(watermarkImage)
    WW = np.zeros((x, y), np.uint8)
    WW[:x, :y] = np.diag(ww)

    # Embedding Process
    for i in range(0, x):
        for j in range(0, y):
            WA[i, j] = WA[i, j] + 0.01 * WW[i, j]

    for i in range(0, x):
        for j in range(0, y):
            WV[i, j] = WV[i, j] + 0.01 * WW[i, j]

    for i in range(0, x):
        for j in range(0, y):
            WH[i, j] = WH[i, j] + 0.01 * WW[i, j]

    for i in range(0, x):
        for j in range(0, y):
            WD[i, j] = WD[i, j] + 0.01 * WW[i, j]

    # Inverse of SVD
    cAnew = np.dot(uA, (np.dot(WA, vA)))
    cHnew = np.dot(uH, (np.dot(WH, vH)))
    cVnew = np.dot(uV, (np.dot(WV, vA)))
    cDnew = np.dot(uD, (np.dot(WD, vD)))

    coeff = cAnew, (cHnew, cVnew, cDnew)

    # Inverse DWT to get watermarked image
    watermarkedImage = pywt.idwt2(coeff, 'haar')
    cv2.imshow('Watermarked Image', watermarkedImage)




if __name__ == "__main__":
    coverImage = cv2.imread('', 0)
    watermarkImage = cv2.imread('', 0)


    val = input('What \type of embedding you want to perform?\n1.DWT\n2.DCT\n3.DFT\n4.SVD\n5.SVD-DWT\n6.SVD-DCT-DWT')


    cv2.waitKey(0)
    cv2.destroyAllWindows()

    def get_watermark(dct_watermarked_coeff, param, watermark_size=None):
        subwatermarks = []

        for x in range(0, dct_watermarked_coeff.__len__(), 8):
            for y in range(0, dct_watermarked_coeff.__len__(), 8):
                coeff_slice = dct_watermarked_coeff[x:x + 8, y:y + 8]
                subwatermarks.append(coeff_slice[5][5])

        watermark = np.array(subwatermarks).reshape(watermark_size, watermark_size)

        return watermark
        pass


    def dct(T, norm):
        pass
    def apply_dct(param, image_array=None):
        size = image_array[0].__len__()
        all_subdct = np.empty((size, size))
        for i in range(0, size, 8):
            for j in range(0, size, 8):
                subpixels = image_array[i:i + 8, j:j + 8]
                subdct = dct(dct(subpixels.T, norm="ortho").T, norm="ortho")
                all_subdct[i:i + 8, j:j + 8] = subdct

        return all_subdct
        pass


    def recover_watermark(image_array, model='haar', level=1):
        coeffs_watermarked_image = (image_array, model, level)
        dct_watermarked_coeff = apply_dct(coeffs_watermarked_image[0])

        watermark_array = get_watermark(dct_watermarked_coeff, 128)

        watermark_array = np.uint8(watermark_array)

        # Save result
        img = Image.fromarray(watermark_array)
        img.save('./media/'," ")
        print("DECRYPTED IMAGE:",'')
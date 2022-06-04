



def sent(k):
    import nltk
    from nltk.sentiment.vader import SentimentIntensityAnalyzer

    sid = SentimentIntensityAnalyzer()
    ss = sid.polarity_scores(k)
    print("outttt",ss)

    rating = 2.5
    if (ss['neu'] > ss['pos'] and ss['neu'] > ss['neg']):
        pass
    if (ss['neg'] > ss['pos']):
        negva = 5 - (5 * ss['neg'])
        if negva > 2.5:
            negva = negva - 2.5
        rating = negva
    else:
        negva = 5 * ss['pos']
        if negva < 2.5:
            negva = negva + 2.5
        rating = negva
    return rating


print(sent("this is outstanding"))
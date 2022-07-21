from rest_framework import serializers
from orderfuel.models import Orderfuel, Payment


class android_serialiser(serializers.ModelSerializer):
    class Meta:
        model=Orderfuel
        fields='__all__'

class android_serialisers(serializers.ModelSerializer):
    class Meta:
        model=Payment
        fields='__all__'
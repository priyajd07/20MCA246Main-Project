from rest_framework import serializers
from fuelstatn.models import Fuelstn

class android_serialiser(serializers.ModelSerializer):
    class Meta:
        model=Fuelstn
        fields='__all__'
from rest_framework import serializers
from delivery.models import Delivary
from orderfuel.models import Orderfuel

class android_serialiser(serializers.ModelSerializer):
    class Meta:
        model=Delivary
        fields='__all__'
class android_serialiser2(serializers.ModelSerializer):
    class Meta:
        model=Orderfuel
        fields='__all__'
from rest_framework import serializers
from doctor.models import Doctor

class android_serialiser(serializers.ModelSerializer):
    class Meta:
        model=Doctor
        fields='__all__'
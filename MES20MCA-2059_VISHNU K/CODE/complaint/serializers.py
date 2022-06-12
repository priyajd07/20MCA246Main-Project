from rest_framework import serializers
from complaint.models import Complaints

class android_serialiser(serializers.ModelSerializer):
    class Meta:
        model= Complaints
        fields='__all__'
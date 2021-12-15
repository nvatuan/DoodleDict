from django.db import models
from Draw.models import Label

# Create your models here.
class Image(models.Model):
	label = models.ForeignKey(Label, null=True, blank=True, on_delete=models.SET_NULL)
	url = models.URLField(max_length=512)

	status = models.CharField(max_length=128, null=True, blank=True)
	created_at = models.DateTimeField(auto_now_add=True, blank=True)
	updated_at = models.DateTimeField(auto_now=True, blank=True)
	deleted_at = models.DateTimeField(auto_now=True, blank=True)

	def __str__(self):
		if self.label:
			if self.label.word_en:
				return self.label.word_en
			return "Label#" + str(self.label.id)
		return "Image#" + str(self.id)

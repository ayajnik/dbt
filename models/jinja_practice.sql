{% set first_sentence = 'Wow! I am inside Jinja world' %}
{% set second_sentence = 'I am going to list down my favorite number' %}
{% set my_fav_number = 5 %}

{{ first_sentence }} {{ second_sentence }} My favorite number is {{ my_fav_number }}.

{% set dogs = ['golden retriever', 'labrador', 'beagle', 'mountain bernese'] %}

List of my favorite dogs are:
{% for dog in dogs %}
  {{ dog }}
{% endfor %}
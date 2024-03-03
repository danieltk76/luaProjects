import ollama
response = ollama.chat(model='llama2-uncensored:7b-chat', messages=[
  {
    'role': 'user',
    'content': 'is michelle obama a guy',
  },
])
print(response['message']['content'])


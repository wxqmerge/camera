import base64
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8080/v1", api_key="sk-123")

with open(r"D:\openscad\cube.png", "rb") as f:
    image = base64.b64encode(f.read()).decode()

response = client.chat.completions.create(
    model="Qwen3.6-35B-A3B",
    messages=[{"role": "user", "content": [
        {"type": "text", "text": "Describe this image in detail."},
        {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{image}"}}
    ]}]
)

print(response.choices[0].message.content)

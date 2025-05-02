from PIL import Image

# Load the uploaded image
input_path = "userb.png"
output_path = "user.png"

# Open and resize the image
with Image.open(input_path) as img:
    resized_img = img.resize((30, 30))
    resized_img.save(output_path)

output_path

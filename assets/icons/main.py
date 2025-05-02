from PIL import Image

# Load the uploaded image
input_path = "pt.png"
output_path = "spt.png"

# Open and resize the image
with Image.open(input_path) as img:
    resized_img = img.resize((150, 75))
    resized_img.save(output_path)

output_path

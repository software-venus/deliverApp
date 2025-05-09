from PIL import Image

# Load the uploaded image
input_path = "track.png"
output_path = "trackmap.png"

# Open and resize the image
with Image.open(input_path) as img:
    resized_img = img.resize((50, 50))
    resized_img.save(output_path)

output_path

from PIL import Image

# Load the uploaded image
input_path = "logo_tnt.png"
output_path = "logo_tn.png"

# Open and resize the image
with Image.open(input_path) as img:
    resized_img = img.resize((180, 60))
    resized_img.save(output_path)

output_path

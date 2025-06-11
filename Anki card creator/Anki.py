import os
import sys
import random
import argparse
import base64
import genanki
from pathlib import Path


def image_to_anki_format(image_path):
    """
    Convert an image file to the format required by Anki
    """
    with open(image_path, 'rb') as image_file:
        image_data = image_file.read()
    
    # Get just the filename without the path
    filename = os.path.basename(image_path)
    
    # Return the tuple format that Anki expects (filename, data)
    return filename, image_data


def create_anki_package(folder1, folder2, output_file, sort_chronologically=True):
    """
    Create an Anki package from two folders of images
    
    Args:
        folder1: Path to folder containing front side images
        folder2: Path to folder containing back side images  
        output_file: Output filename for the .apkg file
        sort_chronologically: If True, sort by creation time; if False, sort alphabetically    """
    # Get all image files in both folders
    image_extensions = ('.png', '.jpg', '.jpeg', '.gif', '.bmp', '.webp')
    
    folder1_files = [f for f in os.listdir(folder1) if f.lower().endswith(image_extensions)]
    folder2_files = [f for f in os.listdir(folder2) if f.lower().endswith(image_extensions)]
    
    if sort_chronologically:
        # Sort by creation time (chronological order - oldest first)
        # Create tuples of (filename, creation_time) for consistent sorting
        folder1_with_time = [(f, os.path.getctime(os.path.join(folder1, f))) for f in folder1_files]
        
        # Sort by creation time
        folder1_with_time.sort(key=lambda x: x[1])
        
        # Extract sorted filenames
        folder1_files = [f[0] for f in folder1_with_time]
        
        # Only sort folder2 if it has actual files (not empty placeholders)
        if folder2_files:
            folder2_with_time = [(f, os.path.getctime(os.path.join(folder2, f))) for f in folder2_files]
            folder2_with_time.sort(key=lambda x: x[1])
            folder2_files = [f[0] for f in folder2_with_time]
        
        print("Sorting files chronologically by creation time...")
        print(f"Front folder order: {folder1_files}")
        if folder2_files:
            print(f"Back folder order: {folder2_files}")
        else:
            print("Back folder: (empty)")
    else:
        # Sort alphabetically 
        folder1_files.sort()
        
        # Only sort folder2 if it has actual files (not empty placeholders)
        if folder2_files:
            folder2_files.sort()
        
        print("Sorting files alphabetically...")
        print(f"Front folder order: {folder1_files}")
        if folder2_files:
            print(f"Back folder order: {folder2_files}")
        else:
            print("Back folder: (empty)")
    
    # Check if front folder has files (required)
    if not folder1_files:
        print(f"Error: No image files found in {folder1}")
        return False
    
    # Handle case where back folder is empty
    if not folder2_files:
        print(f"Warning: No image files found in {folder2}")
        print("Creating flashcards with only front images (empty backs)")
        folder2_files = [""] * len(folder1_files)  # Create empty placeholders
    elif len(folder1_files) != len(folder2_files):
        print(f"Warning: Folders contain different number of image files. {len(folder1_files)} in folder1, {len(folder2_files)} in folder2")
        print("Only pairs with matching indexes will be processed.")
    
    # Create a unique model ID (required by Anki)
    model_id = random.randrange(1 << 30, 1 << 31)
      # Define the card model (template)
    model = genanki.Model(
        model_id,
        'Image Card Model',
        fields=[
            {'name': 'Front Image'},
            {'name': 'Back Image'}
        ],
        templates=[
            {
                'name': 'Card 1',
                'qfmt': '{{Front Image}}',  # Front template - HTML is already in the field
                'afmt': '{{Back Image}}',   # Back template - HTML is already in the field
            },
        ],
        css="""
        .card {
            font-family: Arial, sans-serif;
            font-size: 20px;
            text-align: center;
            color: black;
            background-color: white;
        }
        img {
            max-width: 100%;
            max-height: 80vh;
            display: block;
            margin: 10px auto;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        """
    )
    
    # Create a unique deck ID
    deck_id = random.randrange(1 << 30, 1 << 31)
    
    # Create the deck
    deck = genanki.Deck(deck_id, "Image Flashcards")
    
    # Media files to be included in the package
    media_files = []
      # Process the minimum number of files between the two folders
    num_pairs = min(len(folder1_files), len(folder2_files))
    
    for i in range(num_pairs):
        front_image_path = os.path.join(folder1, folder1_files[i])
        
        # Handle empty back folder case
        if folder2_files[i] == "":
            back_image_path = None
            print(f"Processing pair {i+1}/{num_pairs}: {folder1_files[i]} & (empty back)")
        else:
            back_image_path = os.path.join(folder2, folder2_files[i])
            print(f"Processing pair {i+1}/{num_pairs}: {folder1_files[i]} & {folder2_files[i]}")
        
        # Add front image to media files list using absolute paths
        media_files.append(front_image_path)
        
        # Add back image only if it exists
        if back_image_path:
            media_files.append(back_image_path)
        
        # Create a note (flashcard) with HTML img tags containing just the filenames
        # According to genanki docs: use <img src="filename.jpg"> in fields
        if folder2_files[i] == "":
            # Empty back side
            note = genanki.Note(
                model=model,
                fields=[f'<img src="{folder1_files[i]}">', '']
            )
        else:
            # Both front and back images
            note = genanki.Note(
                model=model,
                fields=[f'<img src="{folder1_files[i]}">', f'<img src="{folder2_files[i]}">']
            )
        deck.add_note(note)
      # Create the package
    package = genanki.Package(deck)
    # Use absolute paths for media files
    package.media_files = media_files
    
    # Print media files info for debugging
    print(f"Media files being included:")
    for media_file in media_files:
        if os.path.exists(media_file):
            file_size = os.path.getsize(media_file)
            print(f"  - {os.path.basename(media_file)} ({file_size} bytes) - OK")
        else:
            print(f"  - {os.path.basename(media_file)} - FILE NOT FOUND!")
    
    # Save the package to the output file
    try:
        package.write_to_file(output_file)
        print(f"Successfully created Anki package: {output_file}")
        print(f"Total flashcards created: {num_pairs}")
        return True
    except Exception as e:
        print(f"Error creating Anki package: {e}")
        return False


def main():
    # Set up command line arguments
    parser = argparse.ArgumentParser(description='Create Anki flashcards from image pairs')
    parser.add_argument('folder1', help='Folder containing front side images')
    parser.add_argument('folder2', help='Folder containing back side images')
    parser.add_argument('--output', '-o', default='flashcards.apkg', help='Output Anki package file (default: flashcards.apkg)')
    parser.add_argument('--alphabetical', '-a', action='store_true', help='Sort files alphabetically instead of chronologically')
    
    # Parse arguments
    args = parser.parse_args()
    
    # Validate folders
    if not os.path.isdir(args.folder1):
        print(f"Error: {args.folder1} is not a valid directory.")
        return
    
    if not os.path.isdir(args.folder2):
        print(f"Error: {args.folder2} is not a valid directory.")
        return
    
    # Create the Anki package
    sort_chronologically = not args.alphabetical  # Default to chronological unless --alphabetical is specified
    create_anki_package(args.folder1, args.folder2, args.output, sort_chronologically)


if __name__ == "__main__":
    main()
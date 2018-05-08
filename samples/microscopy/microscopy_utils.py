import numpy as np

from matplotlib.image import imread
from skimage.measure import label, regionprops

def read_annotation_img(file_path):
    return imread(file_path)[:,:,0]

def instance_masks(annotation_img):
    labelled_cells, num_cells = label(annotation_img, return_num=True)
    regions = regionprops(labelled_cells)
    num_cells = int(1e2)
    instance_masks = np.full((*annotation_img.shape, num_cells), False)
    for cell in range(num_cells):
        for row, col in regions[cell].coords:
            instance_masks[row, col, cell] = True

    return instance_masks

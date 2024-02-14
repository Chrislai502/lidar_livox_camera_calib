import numpy as np
import matplotlib.pyplot as plt
import open3d as o3d
from pcd_reader import read_intensities_from_pcd

def plot_and_save_histogram(data, title, xlabel, ylabel, filename):
    """
    Plot and save histogram of data.
    """
    plt.figure()
    plt.hist(data, bins=50, color='blue', alpha=0.7)
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.grid(True)
    plt.savefig(filename)
    plt.close()

def main(pcd_file_path):
    # Load the PCD file
    pcd = o3d.io.read_point_cloud(pcd_file_path)
    
    # Assuming the intensity is stored in the 'colors' channel
    # This might need adjustment based on your PCD file structure

    # Calculate distances from the origin
    points = np.asarray(pcd.points)
    distances = np.linalg.norm(points, axis=1)
    
    # Plot and save the histograms
    plot_and_save_histogram(read_intensities_from_pcd(pcd_file_path), 'Intensity Histogram', 'Intensity', 'Frequency', 'intensity_histogram.png')
    plot_and_save_histogram(distances, 'Distance from Origin Histogram', 'Distance', 'Frequency', 'distance_histogram.png')

if __name__ == "__main__":
    pcd_file_path = '/home/chris/testing/lidar_cam_calib/scene_based/livox_camera_calib/src/livox_camera_calib/data/single_scene_calibration/1.pcd'  # Update this path
    main(pcd_file_path)

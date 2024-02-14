import pcd_reader

filename = 'your_file.pcd'
intensities = pcd_reader.read_intensities_from_pcd(filename)
print(intensities)
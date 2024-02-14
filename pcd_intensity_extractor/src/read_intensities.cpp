#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <vector>
#include <string>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

std::vector<float> readIntensitiesFromPCD(const std::string& filename) {
    pcl::PointCloud<pcl::PointXYZI>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZI>);

    if (pcl::io::loadPCDFile<pcl::PointXYZI>(filename, *cloud) == -1) {
        throw std::runtime_error("Couldn't read file " + filename);
    }

    std::vector<float> intensities;
    for (const auto& point : *cloud) {
        intensities.push_back(point.intensity);
    }

    return intensities;
}

namespace py = pybind11;

PYBIND11_MODULE(pcd_reader, m) {
    m.def("read_intensities_from_pcd", &readIntensitiesFromPCD, "A function that reads intensities from a PCD file.");
}

cmake_minimum_required(VERSION 3.1)
project(pcd_reader)

find_package(pybind11 REQUIRED) # or add_subdirectory(<path_to_pybind11>) for local pybind11
find_package(PCL 1.8 REQUIRED COMPONENTS common io)

include_directories(${PCL_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

pybind11_add_module(pcd_reader src/read_intensities.cpp)
target_link_libraries(pcd_reader PRIVATE ${PCL_LIBRARIES} pybind11::module)

import setuptools

with open("CHANGELOG.md", "r") as fh:
    long_description = fh.read()

__tag__ = ""
__build__ = 0
__commit__ = "0000000"
__version__ = "{}".format(__tag__)

# Section is used to generate an AMD project file
# Dont't use trailing ,
# Only use " but '
# start static_setup_data section
static_setup_data = {
    "name" : "tutorial-hxs-bitfield-register-pulse-generator-plain", 
    "author": "Heinrich Diebel, Bernd Roeckert, Denis Vasilik",
    "author_email" : "heinrich.diebel@eccelerators.com; bernd.roeckert@eccelerators.com; denis.vasilik@eccelerators.com;",
    "url" : "https://github.com/eccelerators/tutorial-hxs-bitfield-register-pulse-generator-plain/",
    "description" : "Tutorial-hxs-bitfield-register-pulse-generator-plain",
    "long_description_content_type" : "text/markdown",                   
    "classifiers" : [
        "Programming Language :: Python :: 3.7",
        "Operating System :: OS Independent"
    ],
    "dependency_links" : [],
    "package_data" : {}, 
    "project_name" : "Tutorial-hxs-bitfield-register-pulse-generator-plain",
    "top_entities" : ["PulseGeneratorPlainIfcWishboneWrapper", "PulseGeneratorPlainIfcAvalonWrapper", "PulseGeneratorPlainAxi4LiteWrapper"],
    "top_entity_files" : ["src/vhdl/wrapper/PulseGeneratorPlainWishboneWrapper.vhd", "src/vhdl/wrapper/PulseGeneratorPlainAvalonWrapper.vhd", "src/vhdl/wrapper/PulseGeneratorPlainAxi4LiteWrapper.vhd"],
    "tb_top_entity" : "tbTop",
    "tb_top_entity_file" : "tb/vhdl/tbTop.vhd",
    "test_suites" : [
            {"testsuite-name":"testSuiteAbnormal", "file":"TestSuites/TestSuiteAbnormal.stm", "entry-file":"testMainSuiteAbnormal.stm", "entry-label":"$testMainSuiteAbnormal"},
            {"testsuite-name":"testSuiteRegular", "file":"TestSuites/TestSuiteRegular.stm", "entry-file":"testMainSuiteRegular.stm", "entry-label":"$testMainSuiteRegular"}
    ],
    "test_labs" : [
    ],
    "other_data_files" : [(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/resources", [
            {"file":"src-gen/c/PulseGeneratorPlainIfc.h"},
            {"file":"src-gen/simstm/PulseGeneratorPlainIfc.stm"},
            {"file":"src-gen/python/PulseGeneratorPlainIfcPlain.py"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/resources/html", [
            {"file":"src-gen/html-sphinx/.buildinfo"},
            {"file":"src-gen/html-sphinx/search.html"},
            {"file":"src-gen/html-sphinx/eccelerators.tutorial.PulseGeneratorPlainIfc_hxs_diagrams_single.html"},
            {"file":"src-gen/html-sphinx/eccelerators.tutorial.PulseGeneratorPlainIfc_hxs_diagrams_slices.html"},
            {"file":"src-gen/html-sphinx/eccelerators.tutorial.PulseGeneratorPlainIfc-composite.html"},
            {"file":"src-gen/html-sphinx/index.html"},
            {"file":"src-gen/html-sphinx/searchindex.js"},
            {"file":"src-gen/html-sphinx/PulseGeneratorPlainIfc_hxs_diagrams_html.html"},
            {"file":"src-gen/html-sphinx/PulseGeneratorPlainIfc_documentation_top.html"},
            {"file":"src-gen/html-sphinx/objects.inv"},
            {"file":"src-gen/html-sphinx/genindex.html"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/resources/html/_images", [
            {"file":"src-gen/html-sphinx/_images/eccelerators.tutorial.PulseGeneratorPlainIfc.png"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/resources/html/_sources", [
            {"file":"src-gen/html-sphinx/_sources/eccelerators.tutorial.PulseGeneratorPlainIfc-composite.rst.txt"},
            {"file":"src-gen/html-sphinx/_sources/PulseGeneratorPlainIfc_documentation_top.rst.txt"},
            {"file":"src-gen/html-sphinx/_sources/eccelerators.tutorial.PulseGeneratorPlainIfc_hxs_diagrams_slices.rst.txt"},
            {"file":"src-gen/html-sphinx/_sources/PulseGeneratorPlainIfc_hxs_diagrams_html.rst.txt"},
            {"file":"src-gen/html-sphinx/_sources/index.rst.txt"},
            {"file":"src-gen/html-sphinx/_sources/eccelerators.tutorial.PulseGeneratorPlainIfc_hxs_diagrams_single.rst.txt"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/resources/html/_static", [
            {"file":"src-gen/html-sphinx/_static/documentation_options.js"},
            {"file":"src-gen/html-sphinx/_static/alert_warning_32.png"},
            {"file":"src-gen/html-sphinx/_static/haiku.css"},
            {"file":"src-gen/html-sphinx/_static/pygments.css"},
            {"file":"src-gen/html-sphinx/_static/alert_info_32.png"},
            {"file":"src-gen/html-sphinx/_static/language_data.js"},
            {"file":"src-gen/html-sphinx/_static/plus.png"},
            {"file":"src-gen/html-sphinx/_static/file.png"},
            {"file":"src-gen/html-sphinx/_static/bg-page.png"},
            {"file":"src-gen/html-sphinx/_static/bullet_orange.png"},
            {"file":"src-gen/html-sphinx/_static/searchtools.js"},
            {"file":"src-gen/html-sphinx/_static/minus.png"},
            {"file":"src-gen/html-sphinx/_static/basic.css"},
            {"file":"src-gen/html-sphinx/_static/doctools.js"},
            {"file":"src-gen/html-sphinx/_static/sphinx_highlight.js"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/package/xgui", [
            {"file":"package/xgui/PulseGeneratorPlainIfcWishboneWrapper_v1_0.tcl"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain", [
            {"file":"CHANGELOG.md"},
            {"file":"README.rst"}
        ])
    ],
    "src_data_files" : [(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/package", [
            {"file":"package/component.xml", "file_type":"IP-XACT"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/package/eccelerators_axilite_trace_interface", [
            {"file":"submodules/setup2vivado/setup2vivado/common_spirit_elements/eccelerators_axilite_trace_interface/eccelerators_axilite_trace_interface.xml", "file_type":"IP-XACT"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/package/eccelerators_axilite_trace_interface", [
            {"file":"submodules/setup2vivado/setup2vivado/common_spirit_elements/eccelerators_axilite_trace_interface/eccelerators_axilite_trace_interface_rtl.xml", "file_type":"IP-XACT"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/submodules/vhdl-eccelerators-basic-package/src", [
            {"file":"submodules/vhdl-eccelerators-basic-package/src/eccelerators_basic.vhd", "file_type":"VHDL 2008", "hdl_order":"00040"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/src-gen/vhdl/auxiliary", [
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/src-gen/vhdl", [
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcWishbonePackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00070"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00080"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcAxi4LitePackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00110"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcAvalonPackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00150"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcAvalon.vhd", "file_type":"VHDL 2008", "hdl_order":"00160"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcUserPackage.vhd", "file_type":"VHDL 2008", "hdl_order":"00050"},
            {"file":"src-gen/vhdl/PulseGeneratorPlainIfcAxi4Lite.vhd", "file_type":"VHDL 2008", "hdl_order":"00120"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/src/vhdl/wrapper", [
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/src/vhdl", [
            {"file":"src/vhdl/PulseGeneratorPlainWishboneHxs.vhd", "file_type":"VHDL 2008", "hdl_order":"00090"},
            {"file":"src/vhdl/PulseGeneratorPlainAvalonHxs.vhd", "file_type":"VHDL 2008", "hdl_order":"00170"},
            {"file":"src/vhdl/PulseGeneratorPlainAxi4LiteHxs.vhd", "file_type":"VHDL 2008", "hdl_order":"00130"},
            {"file":"src/vhdl/PulseGeneratorPlainUserLogic.vhd", "file_type":"VHDL 2008", "hdl_order":"00060"}
        ])
    ],
    "tb_data_files" : [(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/submodules/simstm/src", [
            {"file":"submodules/simstm/src/tb_bus_avalon_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00020", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_base_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00200", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_interpreter_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00220", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_interpreter_pkg_body.vhd", "file_type":"VHDL 2008", "hdl_order":"00221", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_bus_axi4lite_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00010", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_base_pkg_body.vhd", "file_type":"VHDL 2008", "hdl_order":"00201", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_instructions_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00210", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_simstm.vhd", "file_type":"VHDL 2008", "hdl_order":"00230", "ghdl_options":["-frelaxed"]},
            {"file":"submodules/simstm/src/tb_bus_wishbone_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00000", "ghdl_options":["-frelaxed"]}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/vhdl/simstm_src_to_customize", [
            {"file":"tb/vhdl/simstm_src_to_customize/tb_bus_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00030", "ghdl_options":["-frelaxed"]},
            {"file":"tb/vhdl/simstm_src_to_customize/tb_signals_pkg.vhd", "file_type":"VHDL 2008", "hdl_order":"00190", "ghdl_options":["-frelaxed"]}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/vhdl", [
            {"file":"tb/vhdl/tbDutAxi4Lite.vhd", "file_type":"VHDL 2008", "hdl_order":"00140", "ghdl_options":["-frelaxed"]},
            {"file":"tb/vhdl/tbTop.vhd", "file_type":"VHDL 2008", "hdl_order":"00240", "ghdl_options":["-frelaxed"]},
            {"file":"tb/vhdl/tbDutAvalon.vhd", "file_type":"VHDL 2008", "hdl_order":"00180", "ghdl_options":["-frelaxed"]},
            {"file":"tb/vhdl/tbDutWishbone.vhd", "file_type":"VHDL 2008", "hdl_order":"00100", "ghdl_options":["-frelaxed"]}
        ])
    ],
    "src_tb_simstm_data_files" : [(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/src-gen/simstm", [
            {"file":"src-gen/simstm/PulseGeneratorPlainIfc.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/SetGet", [
            {"file":"tb/simstm/SetGet/PulseGeneratorPlainSetGet.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/Common", [
            {"file":"tb/simstm/Common/Common.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/TestSuites", [
            {"file":"tb/simstm/TestSuites/TestSuiteAbnormal.stm"},
            {"file":"tb/simstm/TestSuites/TestSuiteRegular.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/Regular", [
            {"file":"tb/simstm/Regular/StaticConfig.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/TestCase", [
            {"file":"tb/simstm/TestCase/TestCase.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/Abnormal", [
            {"file":"tb/simstm/Abnormal/DynamicConfigMistakes.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm/Base", [
            {"file":"tb/simstm/Base/Array.stm"},
            {"file":"tb/simstm/Base/Base.stm"},
            {"file":"tb/simstm/Base/ReadModifyWrite.stm"}
        ]),(
        "tutorial-hxs-bitfield-register-pulse-generator-plain/tb/simstm", [
            {"file":"tb/simstm/testMainSuiteRegular.stm"},
            {"file":"tb/simstm/testMainSuiteAbnormal.stm"},
            {"file":"tb/simstm/testMain.stm"}
        ])
    ],
      
    "setup_requires" : []
}
# end static_setup_data section

setup_data_files = []
setup_data_files_sections = ["other_data_files", "src_data_files", "tb_data_files", "src_tb_simstm_data_files"]

for section in setup_data_files_sections: 
    for data_folder_file_list_pair in static_setup_data[section]:
        data_folder_file_list = []
        for data_file_dict in data_folder_file_list_pair[1]:
            data_folder_file_list.append(data_file_dict["file"])
        setup_data_files.append((data_folder_file_list_pair[0], data_folder_file_list))

setuptools.setup(
    name = static_setup_data["name"],
    version = __version__,
    author = static_setup_data["author"],
    author_email = static_setup_data["author_email"],
    url = static_setup_data["url"],
    description = static_setup_data["description"],
    long_description = long_description,
    long_description_content_type = static_setup_data["long_description_content_type"],
    packages = setuptools.find_packages(),
    classifiers= static_setup_data["classifiers"],
    dependency_links = static_setup_data["dependency_links"],
    package_data = static_setup_data["package_data"],
    data_files = setup_data_files,
    setup_requires = static_setup_data["setup_requires"]
)
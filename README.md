# downstream_tools



This will produce a folder called "phasing" in the directory of outputs produced by the wf-pore-c pipeline and run clair3.

Requires clair3 and HapCUT2 to be installed, and a clair3 conda environment to have been created:

conda create -n clair3 -c bioconda clair3 python=3.9.0 -y



Example usage

sh run_phasing.sh --dir pore-c_output_dir --ref path_to_reference --model path_to_clair3_model
#!/bin/bash
#
##phasing


##Process command line arguments
#dir: pore-c pipeline output directory
#model: clair3 model path
#ref: reference genome path

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --ref)
      ref="$2"
      shift # past argument
      shift # past value
      ;;
    --dir)
      dir="$2"
      shift # past argument
      shift # past value
      ;;
    --model)
      model="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

echo "${ref}"


mkdir $dir/phasing
bamfile=$(find $dir -type f -name "*.cs.bam")

echo $bamfile


##run clair3
conda init bash
source ~/.bashrc

conda activate clair3
run_clair3.sh --bam_fn $bamfile --ref_fn $ref --platform="ont" --model_path $model --output $dir/phasing/ --threads 8 --output $dir/phasing/


##Extract hairs for hapcut2
vcffile=$(find $dir/phasing -type f -name "*.vcf")
extractHAIRS --bam $bamfile --VCF $vcffile --out $dir/phasing/fragments

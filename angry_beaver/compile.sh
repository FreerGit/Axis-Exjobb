


print_help () {
    echo "This script compiles .c files to .wasm without emscripten.";
    echo "";
    echo "Usage:"
    echo -e '\t noes-compile -i <filename> -o <filename> -std <wasi-libc location> -e';
    echo "";
    echo "Flags:"
    echo "";
    echo -e '\t (mandatory) -i <filename> sets input filename and location.';
    echo "";
    echo -e '\t (optional) -o <filename> sets the output filename and location.';
    echo "";
    echo -e '\t (optional) -std <location> enables the use of wasi-libc and sets folder location.';
    echo "";
    echo -e '\t (optional) -e needs to be enabled if there is a main-function in the c-code.';
}

std=false;
entry=false;
output="../default.wasm";
while getopts i:o:std:e:h flag
do
    case "${flag}" in
        i) input="../${OPTARG}" ;;
        o) output="../${OPTARG}" ;;
        std) std=true && std-loc="${OPTARG}" ;;
        e) entry=true ;;
        h) print_help && exit 1;;
    esac
done

[[ -z "$input" ]] && { echo "Error: need to specify input file name"; cd ..; rm -rf temp; exit 1; };

[[ ! -f "$input" ]] && { echo "Error: Can't find $input"; cd ..; rm -rf temp; exit 1; }

[[ ! -d /temp ]] && mkdir temp;
cd temp;

echo "Building .ll file";
if [ std = true ] ; then 
    clang --target=wasm32-unknown-wasi --sysroot $std-loc -emit-llvm -c -S $input;
else
    clang --target=wasm32-unknown-wasi -emit-llvm -c -S $input
fi
echo "Building .o file";

file=$(ls . | grep *.ll)
llc -march=wasm32 -filetype=obj $file

echo "Building .wasm file";

file=$(ls . | grep *.o)
if [ entry = true ] ; then
    wasm-ld-10 --export-all -o $output $file
else
    wasm-ld-10 --no-entry --export-all -o $output $file
fi

cd ..; rm -rf temp
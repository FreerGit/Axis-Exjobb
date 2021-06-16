// The entry file of your WebAssembly module.

// import { JSON } from "assemblyscript-json";
import "wasi";
import { Descriptor, FileSystem, Console } from "as-wasi";

export function decoder(filename: string): u8 {
  let fileOrNull: Descriptor | null = FileSystem.open(filename, "w+");
  if (fileOrNull == null) {
    Console.log("could not read file");
    return 1;
  }

  let file = changetype<Descriptor>(fileOrNull);
  let dataOrNull: u8[] | null = file.readAll();

  if (dataOrNull == null) {
    Console.log("Could not read the file " + filename);
    return 1;
  }
  let data = changetype<u8[]>(dataOrNull);
  // let jsonArr: JSON.Arr = <JSON.Arr>(JSON.parse(data));

  // Console.log(data);
  return 0;
}
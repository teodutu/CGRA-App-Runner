# CGRA App Runner

Scripts that allow running Morpher applications on the Versat CGRA

## Setting up the Environment

Run the following command to set up the submodules and tools:

```console
./setup.sh
```

## Running an Application

Because applications need to be annotated in order for Morpher to extract its DFG, this is only compatible with Morpher applications.
You can find them in the `Morpher/Morpher/DFG_Generator/benchmarks` folder.
When you've decided upon an application, use `run_on_versat.sh` to run it.

The script requires 2 arguments:

- the path to the source code file of the application
- the name of the function to map to the CGRA (the one containing the call to `please_map_me()`)

You can run the script like so:

```console
./run_on_versat.sh Morpher/Morpher_DFG_Generator/benchmarks/opencgra_benchmarks/fir/kernel.c kernel
```

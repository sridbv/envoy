load("@emsdk//:deps.bzl", emsdk_deps = "deps")
load("@rules_python//python:repositories.bzl", "python_register_toolchains")
load("@proxy_wasm_cpp_host//bazel/cargo/wasmtime:crates.bzl", "wasmtime_fetch_remote_crates")
load("//bazel/external/cargo:crates.bzl", "raze_fetch_remote_crates")
load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

def _python_minor_version(python_version):
    return "_".join(python_version.split(".")[:-1])

# Python version for `rules_python`
PYTHON_VERSION = "3.11.1"
PYTHON_MINOR_VERSION = _python_minor_version(PYTHON_VERSION)

# Envoy deps that rely on a first stage of dependency loading in envoy_dependencies().
def envoy_dependencies_extra(
        python_version = PYTHON_VERSION,
        ignore_root_user_error = False):
    emsdk_deps()
    raze_fetch_remote_crates()
    wasmtime_fetch_remote_crates()

    # Registers underscored Python minor version - eg `python3_10`
    python_register_toolchains(
        name = "python%s" % _python_minor_version(python_version),
        python_version = python_version,
        ignore_root_user_error = ignore_root_user_error,
    )

    aspect_bazel_lib_dependencies()

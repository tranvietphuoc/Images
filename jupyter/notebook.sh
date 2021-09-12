#!/bin/bash


set -e

wrapper=""
if [[ "${RESTARTABLE}" == "yes" ]]; then
    wrapper="run-one-constantly"
fi

if [[ -n "${JUPYTERHUB_API_TOKEN}" ]]; then
    exec /usr/local/bin/singleuser.sh "$@"
elif [[ -n "${JUPYTER_ENABLE_LAB}" ]]; then
    . /usr/local/bin/start.sh ${wrapper} jupyter lab "$@"
else
    # echo "WARN: Jupyter Notebook deprecation notice https://github.com/jupyter/docker-stacks#jupyter-notebook-deprecation-notice."
    # shellcheck disable=SC1091
    . /usr/local/bin/start.sh ${wrapper} jupyter notebook "$@"
fi

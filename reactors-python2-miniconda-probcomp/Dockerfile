FROM sd2e/reactors:python2-miniconda

RUN cd /tmp && \
    wget https://raw.githubusercontent.com/probcomp/notebook/master/files/conda_probcomp.txt && \
    conda install --quiet --yes -c probcomp -c cidermole -c fritzo -c ursusest \
        --file /tmp/conda_probcomp.txt

#RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 \
RUN conda install --quiet --yes \
    'beautifulsoup4=4.5.*' \
    'bokeh=0.12*' \
    'cloudpickle=0.2*' \
    'cython=0.25*' \
    'dill=0.2*' \
    'eigen=3.3.*' \
    'h5py=2.7*' \
    'hdf5=1.10.1' \
    'ipython=5.3*' \
    'ipywidgets=6.0*' \
    'matplotlib=1.5.*' \
    'nomkl' \
    'numba=0.31*' \
    'numexpr=2.6*' \
    'numpy=1.11.*' \
    'pandas=0.18.*' \
    'patsy=0.4*' \
    'pyflakes=1.6*' \
    'pyzmq' \
    'scikit-image=0.12*' \
    'scikit-learn=0.17.*' \
    'scipy=0.17.*' \
    'seaborn=0.7.*' \
    'six=1.10.*' \
    'sqlalchemy=1.1*' \
    'statsmodels=0.6.*' \
    'sympy=1.0*' \
    'vincent=0.4.*' \
    'xlrd' \
    'pytest'

# Give Conda a power-up
RUN conda config --add channels conda-forge

# Re-add ONBUILD support since this is derived from
# an reactors image that has it
ONBUILD ADD requirements.txt /tmp/requirements.txt
ONBUILD RUN pip install --upgrade -r /tmp/requirements.txt
ONBUILD ADD reactor.py /
ONBUILD ADD config.yml /
ONBUILD ADD message.json* /message.jsonschema

# Close out making absolutely sure that work directory is set
WORKDIR ${SCRATCH}

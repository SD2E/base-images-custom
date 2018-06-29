"""Check that core requirements for SBH adapter are importable"""
import semver
import appdirs
import os

def test_sbol_version():
    '''Ensure sbol imports and is a recent version'''
    import sbol
    version_info = semver.parse_version_info(sbol.__version__)
    assert version_info > (2, 3, 0)


def test_imports_synbiohub_adapter():
    '''SynbioHub can be imported'''
    from synbiohub_adapter.upload_sbol import SynBioHub, \
        BadLabParameterError, UndefinedURIError


def test_appdirs():
    '''SynbioHub uses appdirs to determine cache path. Make sure it works'''
    db_dir = appdirs.user_cache_dir(appname='synbiohub_adapter')
    db_file = os.path.join(db_dir, 'queries.db')
    assert db_file == '/tmp/synbiohub_adapter/queries.db'

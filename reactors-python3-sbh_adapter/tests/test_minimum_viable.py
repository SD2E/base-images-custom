"""Check that core requirements for SBH adapter are importable"""
import semver


def test_sbol_version():
    '''Ensure sbol imports and is a recent version'''
    import sbol
    version_info = semver.parse_version_info(sbol.__version__)
    assert version_info > (2, 3, 0)


def test_imports_synbiohub_adapter():
    '''SynbioHub can be imported'''
    from synbiohub_adapter.upload_sbol import SynBioHub, \
        BadLabParameterError, UndefinedURIError

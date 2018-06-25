"""Check that core requirements for SBH adapter are importable"""
import semver


def test_imports_synbiohub_adapter():
    '''SynbioHub can be imported'''
    from synbiohub_adapter.upload_sbol import SynBioHub

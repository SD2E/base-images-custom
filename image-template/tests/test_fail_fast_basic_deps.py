"""Check that core requirements for fail-fast are importable"""
import semver


def test_bayeslite():
    import bayeslite
    assert bayeslite.__version__.startswith('0.3')


def test_pandas():
    import pandas as pd
    assert semver.compare(pd.__version__, '0.18.0') == 1


def test_pytest():
    import pytest
    assert semver.compare(pytest.__version__, '3.5.0') == 1

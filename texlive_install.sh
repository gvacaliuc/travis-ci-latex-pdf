#!/usr/bin/env sh

# Originally from https://github.com/latex3/latex3
# and then from https://github.com/PHPirates/travis-ci-latex-pdf

# This script is used for testing using Travis
# It is intended to work on their Trusty VM set up: Ubuntu 14.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  curl https://raw.githubusercontent.com/gvacaliuc/travis-ci-latex-pdf/master/texlive.profile > /tmp/texlive.profile
  ./install-tl --profile=/tmp/texlive.profile

  cd ..
fi

# Just including texlua so the cache check above works
# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex

# Needed for TeX Live 2017
tlmgr install xkeyval

# A kind of minimum set of packages needed
tlmgr install collection-latex

# Install babel languages
tlmgr install collection-langeuropean

# Index of packages: http://ctan.mirrors.hoobly.com/systems/texlive/tlnet/archive/
# Other contrib packages: done as a block to avoid multiple calls to tlmgr
# pgf includes tikz
tlmgr install   \
  exam          \
  amsmath       \
  amsthm        \
  amssymb       \
  mathtools     \
  enumerate     \
  thmtools      \
  stmaryrd      \
  xcolor        \
  pdfpages      \
  centernot     \
  pgf           \
  cancel        \
  hyperref      \
  bookmark      \
  pgfplots      \
  bm            \
  listings      \
  graphicx      \
  scalerel      \
  stackengine   \
  etoolbox      \
  listofitems   \
  marvosym      \
  amsfonts      \
  opensans      \
  slantsc       \
  fancyhdr      \
  ulem          \
  algorithms    \
  algorithmicx  \
  float         \
  booktabs      \
  enumitem      \
  polynom       \
  fancyvrb      \
  makecmds      \
  imakeidx      \
  placeins      \
  sectsty       \
  titlesec

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install

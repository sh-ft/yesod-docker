FROM agrafix/ghc7.8

MAINTAINER joel.hermanns@gmail.com

# Create default config
RUN cabal update
# Add stackage remote repo
RUN sed -i 's/^remote-repo: [a-zA-Z0-9_\/:.]*$/remote-repo: stackage:http:\/\/www.stackage.org\/stackage\/ddf3ac57d4c14633e1b0c77100dfceb9a759bf68/g' .cabal/config
# Update packages
RUN cabal update
# Generate locale otherwise happy (because of tf-random) will fail
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
RUN echo $LANG
RUN cabal install cabal-install
# Install newest alex and happy
RUN cabal install alex happy
# Install yesod
RUN cabal install yesod yesod-bin yesod-static

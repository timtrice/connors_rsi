GH_REPO="@github.com/$TRAVIS_REPO_SLUG.git"
FULL_REPO="https://$GH_TOKEN$GH_REPO"
git config --global user.name "Travis CI"
git config --global user.email "tim.trice@gmail.com"
git clone https://github.com/timtrice/connors_rsi.git
cd connors_rsi
Rscript --verbose code/01_packages.R
Rscript --verbose code/02_connors_rsi.R
rm -rf docs
Rscript -e 'workflowr::wflow_build(update = TRUE, view = FALSE, verbose = TRUE)'
git add .
MSG="Rebuild docs, $(date)"
git commit -m "$MSG"
git push $FULL_REPO

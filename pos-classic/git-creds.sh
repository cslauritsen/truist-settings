# after having done git auth login for this user
git config --global credential.helper store

git credential approve <<EOF
protocol=https
host=github.com
username=cslauritsen
password=$(gh auth token --user cslauritsen)
EOF

git credential approve <<EOF
protocol=https
host=github.com
username=csl04r
password=$(gh auth token --user csl04r)
EOF

const fs = require('fs');

const allFiles = [];

// const exclusionRegex = /.git\/|client\/assets\/|coverage\/|dist\/|migrations\/|server\/public\/|.txt|.ebextensions\/|.elasticbeanstalk\/|node_modules\//;

const getFiles = path => {
  const files = fs.readdirSync(path);

  files.forEach(file => {
    const relativeFilepath = `${path}/${file}`;

    // if (exclusionRegex.test(relativeFilepath)) return;

    if (fs.lstatSync(relativeFilepath).isDirectory()) {
      getFiles(relativeFilepath);
    } else {
      allFiles.push(relativeFilepath.replace('./', ''));
    }
  });
};

getFiles('.');

fs.writeFile(
  'files.txt',
  allFiles.join("\n"),
  (err) => {
    if (err) throw err;
    console.log('File successfully created!')
  }
)

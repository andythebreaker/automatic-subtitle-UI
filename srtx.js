const fs = require('fs');

const { execSync } = require('child_process');
const regex = /\'result\':\ +\[\'?([^\[\]]*)\'?\]/gm;
const filename = process.argv[2];

fs.readFile(filename, 'utf8', (err, data) => {
  if (err) throw err;

  const lines = data.split('\n');
  let newContent = '';
  for (let i = 0; i < lines.length; i++) {
    if ((i+1) % 4 === 3) {
      const str = lines[i];
      console.log(str);
      const command = `python3 GoogleTranslate.py "${str}"`;
      const output = execSync(command, { encoding: 'utf8' });
      console.log(output);
      let m;
      while ((m = regex.exec(output)) !== null) {
        if (m.index === regex.lastIndex) {
          regex.lastIndex++;
        }
        m.forEach((match, groupIndex) => {
          console.log(`Found match on line ${i+1}, group ${groupIndex}: ${match}`);
          lines[i] = match.length>0?match.substring(0, match.length-1):' ';
        });
      }
    }
    newContent += lines[i] + '\n';
  }

  const newFilename = `${filename}tx`;
  fs.writeFile(newFilename, newContent, (err) => {
    if (err) throw err;
    console.log(`Modified content saved to ${newFilename}`);
  });
});

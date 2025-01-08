import glob, sys, os

files = glob.glob('*.jpg')
for f in files:
    new = f.split('.')[0]
    new = new+'.JPG'
    os.system(f'mv {f} {new}')

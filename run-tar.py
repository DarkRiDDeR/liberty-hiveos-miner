import tarfile

def chmodx(tarinfo):
    tarinfo.mode = int('0755', base=8)
    return tarinfo

f = tarfile.open('liberty-hiveos-0.6.8.0.tar.gz', 'w:gz')
f.add('liberty-linux-amd64', arcname='/liberty-hiveos/liberty-linux-amd64', filter=chmodx)
f.add('miner/h-config.sh', arcname='/liberty-hiveos/h-config.sh', filter=chmodx)
f.add('miner/h-manifest.conf' , arcname='/liberty-hiveos/h-manifest.conf', filter=chmodx)
f.add('miner/h-run.sh' , arcname='/liberty-hiveos/h-run.sh', filter=chmodx)
f.add('miner/h-stats.sh' , arcname='/liberty-hiveos/h-stats.sh', filter=chmodx)
f.list()
f.close()

#rhminer.2.3
'''
f = tarfile.open('replace_rhminer2.3_liberty-hiveos-0.0.2alpha.tar.gz', 'w:gz')
f.add('h-config.sh', arcname='liberty-linux-amd64', filter=chmodx)
f.add('rhminer/h-config.sh', arcname='/rhminer/h-config.sh', filter=chmodx)
f.add('rhminer/h-manifest.conf' , arcname='/rhminer/h-manifest.conf', filter=chmodx)
f.add('rhminer/h-run.sh' , arcname='/rhminer/h-run.sh', filter=chmodx)
f.add('rhminer/h-stats.sh' , arcname='/rhminer/h-stats.sh', filter=chmodx)
f.add('rhminer/2.3/control' , arcname='/rhminer/2.3/control')

f.list()
f.close()
'''
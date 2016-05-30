// Clean offline slaves in jenkins.
// Run this script in jenkins master script console.
// Or use pipeline plugin to run groovy code.

println('====================');

for (aSlave in hudson.model.Hudson.instance.slaves) {
  
  if ((aSlave.getComputer().isOffline()) && (aSlave.name =~ /ecs-cloud/)){
    println('Offline node' + aSlave.name)
    aSlave.getComputer().setTemporarilyOffline(true,null);
    aSlave.getComputer().doDoDelete();
  }
}
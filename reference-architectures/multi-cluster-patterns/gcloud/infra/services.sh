# Source the library file
source ./infra/utils.sh

# Check environment variables
if ! check_env_vars; then
  exit 1
fi
gcloud services enable \
  trafficdirector.googleapis.com \
  multiclusterservicediscovery.googleapis.com \
  multiclusteringress.googleapis.com \
  container.googleapis.com \
  mesh.googleapis.com \
  gkehub.googleapis.com \
  certificatemanager.googleapis.com \
  artifactregistry.googleapis.com \
  clouddeploy.googleapis.com \
  cloudbuild.googleapis.com \
  --project=$PROJECT_ID
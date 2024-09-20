{pkgs, ...}: {
  config = {
    home.packages = let
      sdk-components = with pkgs.google-cloud-sdk.components; [
        beta
        bigtable
        bq
        cbt
        cloud-datastore-emulator
        cloud-firestore-emulator
        cloud-run-proxy
        cloud-spanner-emulator
        cloud-sql-proxy
        docker-credential-gcr
        gcloud-crc32c
        gke-gcloud-auth-plugin
        gsutil
        harbourbridge
        istioctl
        kpt
        kubectl
        kustomize
        log-streaming
        minikube
        pkg
        pubsub-emulator
        skaffold
        spanner-migration-tool
        terraform-tools
      ];

      google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents sdk-components;
    in [google-cloud-sdk];
  };
}

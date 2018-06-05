 2778  gcloud beta organizations list
 2779  gcloud auth login
 2780  gcloud beta organizations list
 2787* gcloud beta organizations list\n
 2788* gcloud alpha billing accounts list\n
 2789  gcloud projects create ${TF_ADMIN} \\n  --organization ${TF_VAR_org_id} \\n  --set-as-default
 2790  gcloud project create ${TF_ADMIN} --organizatoin ${TF_VAR_org_id} --set-as-default
 2791  gcloud projects create ${TF_ADMIN} --organization ${TF_VAR_org_id} --set-as-default
 2795  gcloud projects create ${TF_ADMIN} --organization ${TF_VAR_org_id} --set-as-default
 2797  gcloud projects create ${TF_ADMIN} --organization ${TF_VAR_org_id} --set-as-default
 2799  gcloud projects create ${TF_ADMIN} --organization ${TF_VAR_org_id} --set-as-default
 2800  gcloud alpha billing projects link ${TF_ADMIN} \\n  --billing-account ${TF_VAR_billing_account}
 2801  gcloud iam service-accounts create terraform \\n  --display-name "Terraform admin account"
 2802  gcloud iam service-accounts keys create ${TF_CREDS} \\n  --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com
 2803  gcloud projects add-iam-policy-binding ${TF_ADMIN} \\n  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \\n  --role roles/viewer\n\ngcloud projects add-iam-policy-binding ${TF_ADMIN} \\n  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \\n  --role roles/storage.admin
 2804  gcloud services enable cloudresourcemanager.googleapis.com\ngcloud services enable cloudbilling.googleapis.com\ngcloud services enable iam.googleapis.com\ngcloud services enable compute.googleapis.com\ngcloud services enable sqladmin.googleapis.com

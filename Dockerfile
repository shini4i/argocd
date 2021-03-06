ARG ARGOCD_VERSION

FROM quay.io/argoproj/argocd:$ARGOCD_VERSION

ENV ARGOCD_VAULT_PLUGIN_VERSION=1.12.0
ENV SOPS_VERSION=3.7.2
ENV HELM_SECRETS_VERSION=3.13.0

ADD --chown=argocd:argocd --chmod=700 \
    https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${ARGOCD_VAULT_PLUGIN_VERSION}/argocd-vault-plugin_${ARGOCD_VAULT_PLUGIN_VERSION}_linux_amd64 \
    /usr/local/bin/argocd-vault-plugin

ADD --chown=argocd:argocd --chmod=700 \
    https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    /usr/local/bin/sops

# To make it work set env HELM_PLUGINS to "/home/argocd/.local/share/helm/plugins/"
RUN helm plugin install --version ${HELM_SECRETS_VERSION} https://github.com/jkroepke/helm-secrets

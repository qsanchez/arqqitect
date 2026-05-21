# arqqitect: Draft

Help the architect draft a chapter of the HLD by conducting a structured interview and writing Markdown files into the chapter folder.

## Step 1 — Identify the chapter

Check `$ARGUMENTS` first. If a chapter identifier is provided (e.g. `07-security`), use it.
Otherwise check the current working directory for a chapter folder name.
If neither is clear, ask: "Which chapter do you want to draft? (e.g. 04-application)"

## Step 2 — Interview the architect

Ask one question at a time. Wait for the answer before asking the next.
Use the question set for the identified chapter below.

### 00-introduction
1. What is the project name and any internal code name?
2. Who is the client or organization?
3. What does this engagement cover, and what is explicitly out of scope?
4. Who is the target audience for this document? (e.g. technical leads, security team, executives)
5. Who are the authors and contributors?
6. What are the key design principles guiding this engagement? (e.g. cloud-native, zero-trust, API-first)

### 01-context
1. What business problem or opportunity is this solution addressing?
2. What are the key business drivers? (e.g. cost reduction, compliance, time-to-market, growth)
3. What existing systems does this solution depend on, integrate with, or replace?
4. Who are the key stakeholders and what are their main concerns?
5. What is the expected delivery timeline and key milestones?

### 02-requirements
1. What are the functional requirements? List the key things the system must do.
2. What are the performance requirements? (throughput, latency, concurrent users)
3. What are the availability and reliability requirements? (uptime SLA, RTO, RPO)
4. What compliance or regulatory standards apply? (e.g. ISO 27001, GDPR, PCI DSS, SOC 2)
5. What are the specific security requirements beyond compliance? (e.g. MFA, encryption at rest, network isolation)

### 03-integration
1. What external systems does this solution integrate with?
2. For each integration: what protocol (REST, gRPC, event, batch, SFTP), what data, in which direction, and what SLA?
3. Are integrations synchronous or asynchronous? Event-driven or request-response?
4. How are integration failures handled? (retry, dead-letter queue, circuit breaker, manual remediation)
5. Is there an API gateway or ESB in the integration layer?

### 04-application
1. What are the main application services or components and what does each do?
2. What is the technology stack? (languages, frameworks, runtimes)
3. How are services deployed? (containers on Kubernetes, serverless functions, VMs, managed PaaS)
4. What are the key internal APIs between services, and the external APIs exposed to consumers?
5. What authentication and authorization model is used? (OAuth 2.0, OIDC, RBAC, ABAC, API keys)
6. What are the main scalability and resilience mechanisms? (horizontal scaling, circuit breakers, caching)

### 05-infrastructure
1. What cloud provider and target region(s)?
2. What compute resources? (VM sizes, Kubernetes cluster spec, serverless platforms, managed services used)
3. What is the network topology? (VPC/VNet design, subnets, peering, ExpressRoute/Direct Connect, on-premises connectivity)
4. What are the HA and DR requirements and how are they met? (multi-AZ, multi-region, failover approach)
5. What environment tiers exist and how do they differ? (dev, test, staging, prod — size, data, access)

### 06-data
1. What are the main data entities and their relationships?
2. What data stores are used? (relational DB, NoSQL, object storage, cache, search, data warehouse)
3. How does data flow between components? Describe the main data paths.
4. What are the data retention and archiving requirements?
5. What are the backup and recovery requirements? (RPO, RTO, backup frequency, restore testing)
6. Are there data residency or sovereignty requirements? (data must stay in specific country/region)

### 07-security
1. What IAM model is used? (cloud-native roles, groups, service accounts, federated identity, PAM)
2. How are TLS certificates managed and rotated? (internal CA, public CA, cert-manager, manual)
3. How are secrets and credentials managed? (vault solution, cloud secrets manager, rotation policy)
4. What data classification applies and how is sensitive data protected at rest and in transit?
5. What vulnerability management approach is used? (scanning tools, patching cadence, DAST/SAST)
6. What security monitoring and alerting is in place? (SIEM, anomaly detection, threat detection)
7. What compliance frameworks apply and how is alignment demonstrated? (ISO 27001, SOC 2, PCI DSS)

### 08-deployment
1. What does the CI/CD pipeline look like? (tools, stages, approval gates, environment promotion)
2. What is the release management approach? (versioning scheme, change management process)
3. What are the rollback procedures if a deployment fails?
4. What team skills and responsibilities are required to operate the deployment pipeline?
5. Walk me through the deployment steps in order.

### 09-operations
1. What monitoring tools are used for infrastructure, application, and security?
2. What metrics are tracked? What are the alerting thresholds and who gets paged?
3. What is the on-call and incident response process?
4. What SLAs and SLOs apply to this solution?
5. What is the logging strategy? (log aggregation platform, retention policy, access controls)

### 10-raid
1. What are the key risks? For each: likelihood (H/M/L), impact (H/M/L), and mitigation.
2. What assumptions has the design made that may not hold?
3. What issues or decisions are still outstanding?
4. What architectural decisions have been made? For each ADR: context, options considered, decision, and rationale.

### 11-appendices
1. What terms, abbreviations, or acronyms need defining for the target audience?
2. What reference documents or standards should be listed?
3. Are there any software licensing requirements or risks to document?

## Step 3 — Draft the Markdown files

Based on the interview answers, draft the appropriate files into the chapter folder.
Create one file per major concern (see each chapter's README.md for expected filenames).
Use Mermaid diagrams where they add clarity — architecture diagrams, data flows, sequence diagrams.
Write in clear, professional English. Be specific — avoid vague statements like "the system will be secure."

## Step 4 — Confirm

List the files created. Tell the architect: "Review the drafts, make edits, then commit to a branch:
`git checkout -b draft/<chapter>` and open a PR."

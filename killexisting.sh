APP_REF=curl --request POST --header 'content-type: application/json' --header "Authorization: Bearer ${{ secrets.NS_TOKEN }}" --url 'https://api.nowsecure.com/graphql' --data '{"query":"query Applications($platformTypes: [PlatformEnum!], $packageKeys: [String!], $groupRefs: [UUID!]) {\n  auto {\n    applications(platformTypes: $platformTypes, packageKeys: $packageKeys, groupRefs: $groupRefs) {\n      ref\n    }\n  }\n}","variables":{"platformTypes":"android","packageKeys":"com.klewis61.githubdemo","groupRefs":"3ee935d6-c347-4c45-967b-5c8e443392e5"}}' | jq -r '.data.auto.applications[0].ref'

STATUS=curl --request POST --header 'content-type: application/json' --header "Authorization: Bearer ${API_TOKEN}" --url 'https://api.nowsecure.com/graphql' --data '{"query":"query LatestAssessmentSummary($ref: UUID!) {\n  auto {\n    application(ref: $ref) {\n      latestAssessmentSummary {\n        status\n      }\n    }\n  }\n}","variables":{"ref":"57aea1d0-0249-11ef-a00d-53021874e31a"}}' | jq -r '.data.auto.application.latestAssessmentSummary.status'

if [["$STATUS" == "pending" || "$STATUS" == "processing"]]; then
   echo "stop the current job"
fi 

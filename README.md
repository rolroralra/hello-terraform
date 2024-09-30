# Terraform
> Infrastructure as Code(IaC) 도구

- 클라우드 서비스나 데이터 센터의 인프라를 효율적으로 관리할 수 있게 해줍니다.
- HashiCorp에서 개발하였으며, 선언적인 구성 파일을 사용하여 인프라의 배포와 관리 과정을 자동화합니다.

## 주요 특징
- **플랫폼 독립성**: Terraform은 AWS, Azure, Google Cloud, VMware 등 다양한 클라우드 제공업체를 지원합니다.
- **상태 관리**: Terraform은 인프라의 현재 상태를 추적하여 변경사항을 관리합니다. 이를 통해 인프라 구성의 일관성을 유지할 수 있습니다.
- **모듈화**: 재사용 가능한 모듈을 만들어 쉽게 인프라를 구성하고 배포할 수 있습니다.
- **변경 예측**: Terraform은 변경사항을 적용하기 전에 보여주어, 의도치 않은 변경을 방지합니다.

## 기본 구성 요소
- **프로바이더(Provider)**: 다양한 클라우드 서비스 또는 API와 상호작용합니다.
- **리소스(Resource)**: 배포할 인프라의 기본 단위입니다.
- **모듈(Module)**: 여러 리소스를 묶어서 배포할 수 있게 해주는 구성 요소입니다.
- **상태 파일(State File)**: 현재 인프라 상태를 기록하는 파일로, Terraform의 로컬이나 원격 저장소에 저장됩니다.

# Terraform 명령어 개요

## `terraform init`
> Terraform 작업을 시작하기 위해 필요한 초기화 과정입니다. 프로바이더 플러그인을 설치하고, 모듈, 백엔드 설정을 초기화합니다.

- 프로바이더 종속성을 고정시키는 `.terraform.lock.hcl` 추가된다.
  ```hcl
  # This file is maintained automatically by "tofu init".
  # Manual edits may be lost in future updates.

  provider "registry.opentofu.org/hashicorp/local" {
    version = "2.5.2"
    hashes = [
      "h1:MBgBjJljfDl1i2JPcIoH4hW+2XLJ+D1l12iH/xd3uTo=",
      "zh:25b95b76ceaa62b5c95f6de2fa6e6242edbf51e7fc6c057b7f7101aa4081f64f",
      "zh:3c974fdf6b42ca6f93309cf50951f345bfc5726ec6013b8832bcd3be0eb3429e",
      "zh:5de843bf6d903f5cca97ce1061e2e06b6441985c68d013eabd738a9e4b828278",
      "zh:86beead37c7b4f149a54d2ae633c99ff92159c748acea93ff0f3603d6b4c9f4f",
      "zh:8e52e81d3dc50c3f79305d257da7fde7af634fed65e6ab5b8e214166784a720e",
      "zh:9882f444c087c69559873b2d72eec406a40ede21acb5ac334d6563bf3a2387df",
      "zh:a4484193d110da4a06c7bffc44cc6b61d3b5e881cd51df2a83fdda1a36ea25d2",
      "zh:a53342426d173e29d8ee3106cb68abecdf4be301a3f6589e4e8d42015befa7da",
      "zh:d25ef2aef6a9004363fc6db80305d30673fc1f7dd0b980d41d863b12dacd382a",
      "zh:fa2d522fb323e2121f65b79709fd596514b293d816a1d969af8f72d108888e4c",
    ]
  }
  ```

### `-upgrade`
- 프로바이더와 모듈 버전을 변경
- `.terraform.lock.hcl` 변경

## `terraform validate`
- terraform 구성 파일의 문법이 올바른지 확인합니다. 오류를 발견하면 설명을 제공합니다.

### `-json`
- 명령어 실행 결과를 json 형식으로 출력

## `terraform plan`
- Terraform으로 적용할 인프라의 변경 사항에 관한 실행 계획을 생성
- Terraform 실행 이전의 상태와 비교해 현재 상태가 최신화되었는지 확인
- 적용하고자 하는 구성을 현재 상태와 비교하고 변경점을 확인
- 구성이 적용되는 경우 대상이 Terraform 구성에 어떻게 반영되는지 화인

### `-out`
- 실행 계획 파일을 별도로 저장한다.

### `-detailed-exitcode`
- 실행 계획 생성 후, 출력 결과를 환경변수(`$?`)에 저장한다.
  - **0**: 변경 사항이 없는 성공
  - **1**: 오류가 있음
  - **2**: 변경 사항이 있는 성공

## `terraform apply`
- 실행 계획을 기반으로 실제로 적용한다.
  - tfplan 파일이 지정 되지 않을 경우, `terraform plan` 동작을 수행한다.

### `-replace`
- 특정 리소스를 재생성해야하는 경우, 대상 리소스를 삭제 후 생성하는 실행 계획이 적용된다.
  - `terraform plan`, `terraform apply` 모두에게 적용 가능한 옵션

## `terraform destroy`
- Terraform으로 생성된 모든 인프라를 삭제합니다.
  - `terraform plan -destroy` 와 같은 명령어

### `-auto-approve`
- 작업을 자동 승인

## `terraform fmt`
- Terraform 구성 파일을 일관된 코드 스타일로 포맷합니다.
  - 코드의 가독성을 높이고 팀원 간의 협업을 원활하게 합니다.

### `-recursive`
- 하위 디렉토리까지 재귀적으로 포맷팅합니다.

# simpleRealGrid
RealGrid Sample
// 두 개의 그리드 생성
const grid1 = new RealGrid.Grid({ /* grid1의 설정 옵션 */ });
const grid2 = new RealGrid.Grid({ /* grid2의 설정 옵션 */ });

// 그리드1에서 그리드2로 행 추가 시 중복 체크 함수
function addRowToGrid2IfNotDuplicate(grid1, grid2, rowIndex) {
  const item = grid1.getItemAt(rowIndex); // grid1의 rowIndex에 해당하는 아이템 가져오기
  const grid2Data = grid2.getData(); // grid2의 모든 데이터 가져오기

  // 중복 여부 체크
  const isDuplicate = grid2Data.some((dataItem) => {
    // 여기에서 중복 체크 조건을 정의합니다. 예를 들어, id 필드가 같은 경우 중복으로 간주합니다.
    return dataItem.id === item.id;
  });

  // 중복이 아니면 grid2에 행 추가
  if (!isDuplicate) {
    grid2.commitInsertRow(item);
  }
}

// 테스트를 위해 임의의 데이터로 그리드1 채우기
const dataForGrid1 = [
  { id: 1, name: 'John', age: 30 },
  { id: 2, name: 'Jane', age: 25 },
  // 추가적인 데이터들...
];

grid1.setDataSource(dataForGrid1);

// 그리드1에서 행 추가 시 중복 체크 수행
// 여기에서 rowIndex는 그리드1의 특정 행을 추가했을 때의 인덱스입니다.
const rowIndexToAdd = 1; // 예시로 1번째 행을 추가하는 경우
addRowToGrid2IfNotDuplicate(grid1, grid2, rowIndexToAdd);

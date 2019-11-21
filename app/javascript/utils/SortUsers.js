export const position = data => {
  const positions = {
    Trainee: 0,
    Junior: 1,
    Middle: 2,
    Senior: 3,
    CEO: 4
  };
  Object.freeze(positions);

  return data.sort((user, nextUser) => {
    const data = [user, nextUser].map(user =>
      Object.keys(positions).filter(position => user.position.match(position))
    );

    return (positions[data[0]] || null) < (positions[data[1]] || null) ? 1 : -1;
  });
};

export const daysInCompany = data =>
  data.sort(
    (user, nextUser) =>
      new Date(user.start_in_company) - new Date(nextUser.start_in_company)
  );

export const birthday = data =>
  data.sort((user, nextUser) => {
    const dateNow = getMonthDay();
    const userBday = addOneYear(dateNow, getMonthDay(user.birthday));
    const nextUserBday = addOneYear(dateNow, getMonthDay(nextUser.birthday));

    const date = [userBday, nextUserBday].map(date =>
      dateNow.slice(0, 2) === date.slice(0, 2) && dateNow % 100 > date % 100
        ? (date += 10000)
        : date
    );

    return date[0] - date[1];
  });

const getMonthDay = date => {
  date = date ? new Date(date) : new Date();

  const month = date.getMonth() + 1;
  const day = date.getDate();

  return `${month <= 9 ? `0${month}` : month}${day <= 9 ? `0${day}` : day}`;
};

const addOneYear = (dateNow, date) =>
  dateNow.slice(0, 2) > date.slice(0, 2) ? `${date + 10000}` : date;

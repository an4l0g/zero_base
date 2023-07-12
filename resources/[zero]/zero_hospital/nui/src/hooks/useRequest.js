function useRequest() {
  const request = async (method, body = {}) => {
    return fetch(`http://zero_hospital/${method}`, {
      method: "POST",
      body: JSON.stringify(body),
    });
  };

  return {
    request,
  };
}

export default useRequest;

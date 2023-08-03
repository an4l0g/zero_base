import { useContext } from "react";
import { UserContext } from "../contexts/UserContext";

const useUserRole = () => {
  const { user } = useContext(UserContext);

  const getPermission = () => {
    // if (user.role === user.permissions_roles.full_permissions)
    //   return "Lider";
    // else if (user.role === user.permissions_roles.half_permissions)
    //   return "ViceLider";
    // else return "Membro";
    if (user.permissions_roles.full_permissions.includes(user.role))
      return "Lider";
    else if (user.permissions_roles.half_permissions.includes(user.role))
      return "ViceLider";
    else return "Membro";
  };

  return {
    getPermission,
  };
};

export default useUserRole;

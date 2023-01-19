import jwt from "jsonwebtoken";

function jwtTokens({id, username, avatar}) {
    const user = {id, username, avatar};
    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, {expiresIn: '2d'});
    return ({accessToken});
}

export {jwtTokens};
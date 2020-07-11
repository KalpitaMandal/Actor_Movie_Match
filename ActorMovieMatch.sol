pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;   // To allow returning of string arrays for functions

contract ActorMovieMatch{
    struct actor{
        uint256 actor_id;
        string actor_name;
    }
    actor[] actors;
    
    struct movie{
        uint256 movie_id;
        string movie_name;
    }
    movie[] movies;
    
    
    uint256 act_id = 1;
    uint256 mov_id = 1;
    string[] names;
    
    mapping (uint256 => actor[]) movieToactors;   // Mapping Actors to Movies
    mapping (uint256 => movie[]) actorTomovies;   // Mapping Movies to Actors
    
    function add_actor(string memory _name) public {  // Add actors
        actors.push(actor(act_id,_name));
        act_id++;
    }
    
    function add_movie(string memory _name) public {  // Add movies
        movies.push(movie(mov_id,_name));
        mov_id++;
    }
    
    function actor_moviesList(uint256 _actorId, uint256[] memory  _moviesList) public {  // Association of one actor to multiple movies and vice versa
        uint256[] memory list = _moviesList;
        for(uint i = 0; i<list.length;i++){
            actorTomovies[_actorId].push(movie(list[i],movies[i].movie_name));
        }
        
        for(uint i = 0; i<list.length;i++){
            movieToactors[list[i]].push(actor(list[i],actors[i].actor_name));
        }
    }
    
    function getMovies(uint256 _actorID) public returns(string[] memory) {   // Getting the list of movies for one actor
        delete names;
        for(uint i=0;i<actorTomovies[_actorID].length;i++){
            names.push(actorTomovies[_actorID][i].movie_name);
        }
        return names;
    }
    
    function getActors(uint256 _movieID) public returns(string[] memory) {   //Getting the list of actors for one movie
        delete names;
        for(uint i=0;i<movieToactors[_movieID].length;i++){
            names.push(movieToactors[_movieID][i].actor_name);
        }
        return names;
    }   
}

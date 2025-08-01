import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import '../styles/mobile-navigation.css';

interface BottomNavigationProps {
  navigation: Array<{
    name: string;
    href: string;
    icon: React.ComponentType<any>;
  }>;
}

const BottomNavigation: React.FC<BottomNavigationProps> = ({ navigation }) => {
  const location = useLocation();

  return (
    <nav className="d-md-none fixed-bottom bottom-nav" style={{ zIndex: 1030 }}>
      <div className="d-flex justify-content-around align-items-center py-2">
        {navigation.map((item) => {
          const isActive = location.pathname === item.href;
          return (
            <Link
              key={item.name}
              to={item.href}
              className={`nav-link d-flex flex-column align-items-center text-decoration-none py-2 px-3 position-relative ${
                isActive ? 'active text-primary' : 'text-muted'
              }`}
              style={{ minWidth: '60px' }}
            >
              <item.icon 
                size={20} 
                className={`nav-icon mb-1 ${isActive ? 'text-primary' : 'text-muted'}`}
              />
              <span className={`nav-text ${isActive ? 'text-primary fw-medium' : 'text-muted'}`}>
                {item.name}
              </span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
};

export default BottomNavigation; 